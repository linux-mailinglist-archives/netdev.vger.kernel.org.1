Return-Path: <netdev+bounces-143633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE29C3666
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864A51F21B67
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A914B956;
	Mon, 11 Nov 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="goi/eXtv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AA14B075;
	Mon, 11 Nov 2024 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290905; cv=fail; b=EPaksKeUoVCElxgTrfCfhKVOm4xJl8Cjb+lKYpBTGXFnY6iAG6Y+qDfotfMuJKqpIZGYMg0ThCEQxIZRojgzE9XtccGto5BW7NWM62e+WviX7/KdtLLmaqe+eZboaHjVsozw1YX5asOEBNnNCQMqXBSopbBF8bfacDnIJk1Q7TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290905; c=relaxed/simple;
	bh=LjqgiehF70pOTaA+fYQ8Epbe+yz1HTdq2u7K9bM73dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b3CXqCbxrPJW2/WqzHhzDm1p2KtgDBoORemOa5EPNkJ14tbT/DGFX7LdZ0Rf1+tuhnFohpU0ay1PzA2Vo5Tl0kc1AkEph+gYuHv4s+b1rALV9gm5sUeCZaqysJfxBcgCXui8m/QhHdYMEUvVEFa9UCa4dgUKCuXGl3ZNv7JJYSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=goi/eXtv; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P59I26Q/4TXGcaUEqcBP34eHqFkvhrabLDQUr5beMNLEKbUbu46G3eDMBEZqcyA+2X7Z898zcW3A9TpcTXq/wFzdH8YdW2/2TnGLMMICrpaKFVxrQ5CJItOQxCoT8JJ7PzrSeG2V949o0WOhDeQTu7A7BGxt7lvbIYriVGladtrYFKofDBSZoIO3vEiBGPRQRF/ay2OxkLHLNJVcV0QNnCpHs7zviIs9SM6G3GdjOYN8Ai+QSt7T/+u7UgGrVgm++Gps1NLwhpgSaV/UPS0cbFQYjElZrIr3ClzHoeKRxf2vZwDY29peseMnYOCe0IOBXATYeASnm529aLyj6Io6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scK0KinTJsqbTwKoDMiw4G+RveaMiwTj5YF/ayAhaO4=;
 b=Kv5YdqI3s5/CvbOJWd1mXNyxYoDx9nIfH/YxE66+ECxcoO/JUD7GTlBTapinA2N9z2ZfzBwTxtr88eamHUtTUJySAvJ3rzA9ufvvKjlzbvGiZ+mJ1q6M49wRPfr0BOmr7Byt5To1d6qbWoUgod8A/gpRpseTD/w6sKY5BpLaHh4hDpy3pEqN1xQYeM1vSCyWKzum/BkFbkT0b/ucWKe2ALikeGGFtcQ1FKjXPM4GFYd5YuzvVUlFKNly7vCO8fKe535Ra+PJsKbmMfKYFQCX5+rx8o3/L4aPqCk/nc2BVRwz3Bws+znprtqoC3tieEeYXCllatPkiKlXLf07x/RtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scK0KinTJsqbTwKoDMiw4G+RveaMiwTj5YF/ayAhaO4=;
 b=goi/eXtv6PATtzmrG/sq4smgiX8PKNwYKDuEptg8cZyU11mrXibcWVRTf6hV7d6RbBDhtI1R1yH2SPybXTDkC4Q7veDX4ZfGwfXwUZ8eTrBlCw5utbe3hyZJ2uFevZcjwJJa4WZxqxBpGnSYK54mtiJCJrLjN3QJoUziLdXp9hWtnLvK5vXqHIMV92J9doouBUyesNHsgI08mvDw2KghWxT0Yfetwk3CAfO9ntbhNQlcxvfPr6l1lak++Ca7Bfd+xx5Hio7PKXjX6khvwQY3CNdVAM8DV6xwNCyXeapIalUNwY5AaAdXi0Id3vuUxhyxjVONKem1R7PfG74azwtPkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7745.eurprd04.prod.outlook.com (2603:10a6:20b:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:08:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 02:08:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 5/5] net: enetc: add UDP segmentation offload support
Date: Mon, 11 Nov 2024 09:52:16 +0800
Message-Id: <20241111015216.1804534-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111015216.1804534-1-wei.fang@nxp.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6b4985-c662-436d-f72a-08dd01f5b710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KrXjtfc7gVozWT8NwHvGd5MNH8mEIRFqOcdLQHWi5yo5CootAwkdzcYx4OjT?=
 =?us-ascii?Q?9X5KXpUU6O7JIG3Yu1z68B99OD33hd/lONNg2Jtod5tseoeeUStmHbfkiMMO?=
 =?us-ascii?Q?6lx3YX1cN0btGrWvwQMQ4QNhRtrDBl07lbgiONSeax36w8fHupdd6szqwhE3?=
 =?us-ascii?Q?5lUIsin8tV+loEOI/iOUea5P87OrEAJtbr2h1ChbG3u+5KG0VNGB2IvZEnep?=
 =?us-ascii?Q?IiaW9XdlhCUTKSCs+edVdQ2QenksG7sOpj1fqRzOoPqDx1uReJCpz46zxGI9?=
 =?us-ascii?Q?QSzRk8WQY0893eYQgOYR9eokSts0ECuvsucZLq6DZQ5H/fEWE8CcE2LB9bau?=
 =?us-ascii?Q?gGwAr6Ids2gZj/yypxvXQgk0dSWAlpcW+E7ydQeguLfVIhARWlqvUy3VMj9q?=
 =?us-ascii?Q?vZSbkkpccdnlWiiM7IJqg7ALufrOcnQbMWKmWUiIAxa9yFI6t1ZdV9oHov88?=
 =?us-ascii?Q?P1btQvQ/me1OPkOERxQcckEBvIhQZFvujTYgSPmfAE2sNh8WBIjnJ0dl7Vg2?=
 =?us-ascii?Q?gdZRCcvHk2eFForsbseeHGvfEZ/ckxTJ5iLNH9gZPx/GtDd7ukfx/4KROFoP?=
 =?us-ascii?Q?ReB1vjrcpV80xhCbAZ7ebBF+vgDVoUDwx+9Mcys6ZBMbkW580Gwdgx/HxC87?=
 =?us-ascii?Q?T6Dt27/8P1QnHAn+jw5gURnHtHlTNpMFKaoWscdDmXvGXMJj/oUCvrRZN7DD?=
 =?us-ascii?Q?9c7Cmv122zECNf1/wUmbWpLy2TyOCw9bMpdgEfgO4HjBkebkGsSvRB/vG5rd?=
 =?us-ascii?Q?/ZeR23w8X7/BcoVxaAVcW+ulu5uU6EkngpXLoPMurtjUlrL6JBDebIlF9834?=
 =?us-ascii?Q?37aRI9Vfong1sBLOGTFAONwK3BIg+qDtgXL1NDK2uVX16gqbb4xp5kY/ZBgB?=
 =?us-ascii?Q?TLs1g2iTS871K1/T4ryFmC9YhUolzT5M9tCTeWth0+MM0V9t6rREhkM6Ipl0?=
 =?us-ascii?Q?vFq2QrFGYzPz35mYM9lmiDKbl7Nydm07xruLKMoJWigDmDg+w7VYJ5IWju5y?=
 =?us-ascii?Q?sx87oIJ5MHosfCiaXtq6EmRSX3XUbfqzmnFianys5j59U/xR8DBVpfPqakYC?=
 =?us-ascii?Q?63O7JET93mMrtnFQf4Et1xzbsMu9nqdojVqSE9OiQi/9hux5fTXW3z127vNM?=
 =?us-ascii?Q?6zU9H36b0iWBstuCQgICM/EJAhYDwcSKRM9dtbDzn3plfe7lgeCsoi4Y87Vu?=
 =?us-ascii?Q?dBu9C4FGw8v1Mf3htA0tmmOyKP0j9/f0pUHdlm+dlNaXZH6L1KlCbsFGT6ym?=
 =?us-ascii?Q?+V+TPE3GWtr3ygHRJug4tbhczAve7JwlMNMsu8HhAnjqMk6xkh3j4zf+IiaK?=
 =?us-ascii?Q?vbpK/wOVlqPz0A/fiVdcbOHe6oE3RpR7pWbMS+P+Bwt6orbB1xnj+RaQ9ZIM?=
 =?us-ascii?Q?POYEQqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CSa5YGxrbp3ni9nDNzQoeEoCrpiinGqIqWFFpqXox3kNSG/yV9XECElxjfJH?=
 =?us-ascii?Q?udMAtVdp11uqqZJC7FDMPAQtbISqpv8P2YQ90kH1nLhiBgahEOsPqHY+0cEu?=
 =?us-ascii?Q?9CtTIqnrDfxvo1fzlc1gDoM+5PT+x05LghxGPGCqgK1uoAND310f3yWfz7x0?=
 =?us-ascii?Q?tgSGkQltK3Mj6Vve92HaQ6HvrpwQzpVwdlAUp4d3WZuA9WQmwlwU8SYoMdwz?=
 =?us-ascii?Q?LrASLzCEZtkbLklk80gup9jx60Ry/cSwskKXMsZAof5nQX+S7MfCvMkPif9j?=
 =?us-ascii?Q?2tNCRp6zd0/Ckyy7ralxN0Buby189UZM/zLRdmWuaOG+LnkLQImF+bov2IYo?=
 =?us-ascii?Q?nVOlPfJ932DupB1NaL8dXWRk44zqHe0iVZ2MaG9nnBmxnAXw0sgeEI76AORy?=
 =?us-ascii?Q?mNL1uWVNv+OVKZ+Q64WZA+ndmaC8bvAdGJYVarVWytcXAsFwHR4PVNPb8iRv?=
 =?us-ascii?Q?H1pJgC0S7/UYJ8vb0VUbXCiW9Z+jphck/WbzjHIjSSalLzO5EYHuSfatoxbY?=
 =?us-ascii?Q?A84oyTpVg2UmggCSB+/raj9vMcfGWXg6zpx7sVxPa9Ht6BagMvEiQblCntyk?=
 =?us-ascii?Q?dh5h/bZhC9soFduGacu3hcvJvZ69VVEik2cCryGwUQ/CERklcy2z95HUNf9j?=
 =?us-ascii?Q?CRMPsDQjembzIMDFaS9eSn3cukzJL4JNUpqegr1j4+0kwXJOwnCpz/aqTFok?=
 =?us-ascii?Q?A/Sc1h6ezX6iNBc4DXcDRbYvSyVt8KUib01j9v0ATZHh2D5EqA/fbHfURFnB?=
 =?us-ascii?Q?3ZSbTaQsCxIC3WcjDmfXEYiZyDBy+KArJ91Q746JRQLAaRtIPmtrqY1EVyoo?=
 =?us-ascii?Q?UuvnZellsN7u1qP30bPP3jaNVyW+4KF8LI1ZrCRv6uMn+Ezo+7Zv5OJc5bVo?=
 =?us-ascii?Q?OaEVnQX3HTLUl8DJts76IPdKsjvE+g25DzXwWuay5I61VSnBeIdNDaUlrzZF?=
 =?us-ascii?Q?dYyDsGpuw8GnjF8RCon7LMMA9til0FjkffrL5SaYlW8xiKBQ993Qn+cU20XM?=
 =?us-ascii?Q?YsH3odErUboBqM3y+SVeDyZPvxR2IRMq/UxxKvW+z8xOiqjgWpXWmu3MzS1e?=
 =?us-ascii?Q?O72ryMrSEmetSR8Rfr9iiDmuAk6GAulGLwQnSEM5S4ibX6GYP3Q3cXPhg4Yp?=
 =?us-ascii?Q?ZVLS/uYRJB8UpfCkDHYL4seyNdKfz01SdfXLdGcU6GLl1M9jXxQgTXNxbrHg?=
 =?us-ascii?Q?TovHHs/uQ2nfLf3/I0stMJ+K+SdgFHvP2EMkGNSztRg6IgzbrU2Q+uZwY/Md?=
 =?us-ascii?Q?1+fDJraJLRX59Rp/MZqNA1LICYk3CDRiKHcYL7GQtbwoVG+eZ0wk9Ok5RkwS?=
 =?us-ascii?Q?7ijyD38SqBVlxNWSMB00el7CWRYkueKUi8dCzQ19sFAKLTWHNLAEzBreosT5?=
 =?us-ascii?Q?5Etvgoo+VnTqjON7YUMqbYa67Dmm4TCVZA/G0FvMbx2d2aP6v1IzkEr1sPCZ?=
 =?us-ascii?Q?s2aQ87UKmt5fcMFzf0eympkDgXPm5ZEI2mRtCBW4p/wURdl3lBuUxbjvpPDs?=
 =?us-ascii?Q?M8RqBEL2kHUkWpdwTz2cRNa0JwmOxVn/RDt5V1suDC6SddQbOfXSyoYDNDHd?=
 =?us-ascii?Q?v/b/gR6AoxVkB9bM656ma8pm3IhyQNBrb7ToNB7D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6b4985-c662-436d-f72a-08dd01f5b710
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:08:20.8295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTstDHTR+uWJ3ifB8rIPF4+6HVLd/H849BwgGTbWz2fBPrALIPiVBeZHevkIeXrlEcS8BkHoe8FfGrJCZGEPrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7745

Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
enetc and LS1028A driver implements UDP segmenation.

- i.MX95 ENETC supports UDP segmentation via LSO.
- LS1028A ENETC supports UDP segmenation since the commit 3d5b459ba0e3
("net: tso: add UDP segmentation support").

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2: rephrase the commit message
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 82a67356abe4..76fc3c6fdec1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 052833acd220..ba71c04994c4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -138,11 +138,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-- 
2.34.1


