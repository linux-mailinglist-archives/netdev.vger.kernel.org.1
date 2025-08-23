Return-Path: <netdev+bounces-216238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A0B32B8B
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B3F9E4532
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556BC2EBB9E;
	Sat, 23 Aug 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vag2lKxa"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5E2528EF;
	Sat, 23 Aug 2025 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975727; cv=fail; b=GEnEdjJmw9HY04wU84Vh0fNlta0M+/9uPwe1X/hDcnRUFzpRv6i1UCZ7vp74ElihZSr9DpF3laMT8VNmwHfAhOHz6x/2RIU7brJy3hy431PsAb9bfO3wzXSeQgBbb9S8HonDOR0sXVZE2GHaVl+8JC5EqsCAcU9eLVppaLLSEj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975727; c=relaxed/simple;
	bh=Ric231oz0vZWok5/h260AvDKcz+q9pI/BxCLi34/lRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZxYv7KdauteLH/7GemIJsq6nW2+zqAtt1jtLtdaUya/A77LLEYp6bMTE0lWTpYaOEFp+fBRHg7KvwfxnD4jz9s6PRjg+jFRUIgab5YblSNmwAQGXdO47kbmEili9kvLKR6GDQSXqndLgOIwcyxSWEgSdQXrmMmsqaQPDntF9Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vag2lKxa; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhPEED9ESA1Elcup1X2v0o3u3Jyn4+SwnRsJfBczunSjVM5vcDemDHpobCjZsjFUDYzqcZdfeBIrfIC53koyowoFzfuZ5l/93Dt/KqLamibZgOFI/2snZsIbbOtD8RfsQovRCMGlBHp9b8UV64evyZjXFHB37eNhHSmixU1I6vXNlPqGi+nXlDFxIAXcTuFAZTxfLaKTIS3Ts68/jeruLCgwS2y3xvScj81gqy0H14qD+W40lmLH0BUSzlgrzdZUoNFdELBYZmLm8jq3fUuR60ukr7YxngTy8+S9O464/3tC5Mh7IPpGPTniMSTQlMGRLrlqn4NRxI1+OS2Axxb1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKPtWeLIzuIBgEn0uDbWyxnBCkyBMnXd8CX7/1+cYIU=;
 b=ETfd16g1qprVno6jZpn6RJk1a6ZMmwOQlwyCAaCEe0LQyF6vmWEj38RydzTCzS2sq+1FxzIE7FHgFevk7a+nztR0zEj6ePBBVSOjNlbHD3aNUdy+3pDuwNVXQwwvl8xdo+/Q2kCPmYM2jriv0XUcfE5uz0MOswYk22H8eY0d+I3POyfaQwhsbk12L20s5p/UymqKYMY7oYukDg12jfCIav/AdBvGiO+6aIEnbozJEgsS8/tHEpu9szGQFJ4d3rdYRoYKazi/pQVhSDLJ2fonYUYjFheQmpvVYVD4ZMBImhCSP3H1ogingKqElgNnkvit5G050LAmeWbTymI6cAjpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKPtWeLIzuIBgEn0uDbWyxnBCkyBMnXd8CX7/1+cYIU=;
 b=Vag2lKxaLgeozjoKvs2MCSnRXTfMP/gSI3LRy63plcWo5QIofr1Ls7FO7w5vI9ZxeaIndokiiTLTOwZXa0MloS4bYOARvWT8DDgDDDqqYwOxh5U/XcY47di2inmNw3K1/9TSE/JB1qtADdxh8NIp9x/JA0nl9lEzhGP0vInvYe9epcLVQNg0CGnATk5ni0D3UYTYIsoQK00RtZ8QlW8fCPa/HHBOsLu/ZU7xNV8QQkEKUoFDQcNQGodpX7J65fWr9aUtj00FxCELjIAetQbVQqUX/9qMoxyVo9jRmF3Xg3d5JrjxDE2OiwIwTv9EA6nFKZOP1U9FjjpL++N2CqBMGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB10456.eurprd04.prod.outlook.com (2603:10a6:150:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 19:02:03 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 19:02:01 +0000
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
Subject: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support configurable RX length
Date: Sat, 23 Aug 2025 14:01:08 -0500
Message-ID: <20250823190110.1186960-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823190110.1186960-1-shenwei.wang@nxp.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|GV1PR04MB10456:EE_
X-MS-Office365-Filtering-Correlation-Id: 65014863-676f-4fc7-eaf5-08dde2778ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXWXHzHzRzJHWBw2Zi2oDJ9h7OctIwHMf2GP3nu40ylyItd4mFqErKeJopYa?=
 =?us-ascii?Q?14gzCPlaV89Uaf7YcrwhyGSv5PhVFVhesM/+jo34028Lho/N7n/6XhJSXBLm?=
 =?us-ascii?Q?80BZG3CZa4GeiULLXdApoEqSDMuYkW7NjiiImF+gpAq2CWhN9axxTNL44PYB?=
 =?us-ascii?Q?o20QK/47AAlIeuMsfqcqtlhPrjwKYVyUPAJmOIaiK9zBRxzMdwrJBU1iDvLE?=
 =?us-ascii?Q?8CMlOZ+Xy0dO7ETtNr7091Ra+47KgX/lh0gHZBPicZgJLTyV0TTN3OzZF7aY?=
 =?us-ascii?Q?CAFK2Hyarm0z3Gnkf4JYoMDLUondaIxiQr7z8pDrB7OZDtnF72SAv83/acZw?=
 =?us-ascii?Q?IiZqk+HNiT4F91q+vqKgMpwyI1PaQOzy1eBVuw3ImArdBlulm6eLreHlkvTQ?=
 =?us-ascii?Q?6blRZyigEXNUCBHsLuZyVVubV730a2+WpONZHr8b8VYQ660OAipIgiG40fT2?=
 =?us-ascii?Q?hQTSyrXC1IpOGYR/z/pFARtINtGdeaOPitTwRb+ZcdJHmrUxo+qM+X+dyHWW?=
 =?us-ascii?Q?NRzAfxAC2X1UeFFNc6Ny89PWTUAktzbnZqRMNQQDpphXi81BvYfK1xvdW41Y?=
 =?us-ascii?Q?utdGNalOhv4IPboFgzlUaXfFBynN+dk9QVsr2TfdkV5BcjOkPi+0wd3Ok0YV?=
 =?us-ascii?Q?OvS2YG0LYl42XNKgmxUh0Y3btCw6D2gkprwac7wBRq/xc3nadZxIHEDVtYrq?=
 =?us-ascii?Q?wxCccnlTE5hjTGpuM7lndoQrJi7jOOqBao8t+ZPEQ253oncb/bZUapt5mrPJ?=
 =?us-ascii?Q?6beuXxYKSR019JgUaAoJ2tPc04MirbTQpsKbjjJ0cH3/uSUNi87OKReqVg7U?=
 =?us-ascii?Q?nvCm2bpnN//n6kVh4Xgsr9ef3B33CGXPPkTkNKzs7tVGdrCXT1f0jgcOyija?=
 =?us-ascii?Q?M2D+OqlR61sEaylMBDq8GBOPpWkVBJzPhrIgia0gWpy0018hFoU1LqbMzQfS?=
 =?us-ascii?Q?1XBwLdNbT9sEi/KQ6t+jmRkDYybdACSdmG4VFM6uVxovM7J1QG+4lKQibv8M?=
 =?us-ascii?Q?TziSBzb2b+dE5/oyWlLBaoqzmC+8qyXRRr7b87j1/8dkpiX5Lo64F7r+2CiZ?=
 =?us-ascii?Q?kw8lUe2h14uVJQbzd5Eg417yGeYg5sBDjh3R2IgoGxk7E4ZeI4giSFqtRK4y?=
 =?us-ascii?Q?HQGLM/AfMwC8VOGEmqCff0RtjHPOdenzVLmJKiJ+NbbvwOxu0i2FvbLlfi0O?=
 =?us-ascii?Q?IC6aiV2XLsnpvabVh1zGCXSpT4AMD8pzm2lrCP4G+DJ7SqlnuCOE5iG1WEvd?=
 =?us-ascii?Q?uOfQmn9kn0lkyE31xGCJBFLILV2PLpUD5zfAUmNVbaH0XJN3yDJZy+qBQ+l0?=
 =?us-ascii?Q?tgRjoled+8kFtV9nkcq8aCJtbcfcO347wXlOgQLV44eFuTFgeB0mk9sm9c4l?=
 =?us-ascii?Q?nxmEeZ/Wrom7oVduH3TZJ2CSQ5+aYmE96i/gvDg+BSU1oQDi9cHdpSMr/Bkj?=
 =?us-ascii?Q?V1ceUj4WnKTwPYt28yFr4mKa5g8wd+q1+eH0sMnYZ2ylxZdKuvmuaVljdWQ0?=
 =?us-ascii?Q?FyyEHSlaaR6vwAc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3IOeZEIMAojP+aBVYtFGub5z2sbFwKe85iiAqoPeH438UG9+1zsyMNXqgMqA?=
 =?us-ascii?Q?QhjvFUXbAxs8OlBUcG+U4QMK3+0P8/uE0C66OdkWWrzZBZ25b/goV7lZm3Fz?=
 =?us-ascii?Q?IJ8w5ciX+8OvQSeSVZ7jKyOvzGNSarQT/0MA4FNdgFD54aclgaLGWjL57e9l?=
 =?us-ascii?Q?E/kjJ79HwWCkbnrhiVNuInUAIpiHigc9+E67KBuHCLdGkbG7Hx2reZf2R0Cg?=
 =?us-ascii?Q?Rtmor11SJI2/Uv0Czs1D5PuDKXyBAVP0gjVHKeAJWgkvDAKdPETp+W2fbP5I?=
 =?us-ascii?Q?rKzluyVNeUZjCj62uv5zCrKKluyTODw+pYK0B2rHj9YXDnwJIWrk8cTdSbFX?=
 =?us-ascii?Q?I+XMR15ICBCSoJ1/4Q7ah5rWjzWrOuBDEAQrg75qGV2m0c1hJhb7NnByNEcZ?=
 =?us-ascii?Q?xj+upkct+FF46mzzPvg9cNa1M+4x11fLKqJlxpY9I422vAgynTABSIyKXT4i?=
 =?us-ascii?Q?yXMFjWLOG3vDaiQz9DXsDi+mJ7vGcAABJ+ZhzZjRZ++eO1oTIwUTuAZqtRoG?=
 =?us-ascii?Q?5GUSGSIaDtCECr7rKvhgk/2NkBQeE8M3JiFjN7uyHIc9YUOPCBh41/J6AWpi?=
 =?us-ascii?Q?0osMUf32pgLVJ6x7TOzwTqSdjTGnhNGbXg6vFcSxiyq3q8CA1YnzkuZIpIj7?=
 =?us-ascii?Q?4Koo2QJD46nyXIwSxVBvl3hINVjOBYmJyALmm7y4okHswXet1YRAgWZcoYBp?=
 =?us-ascii?Q?e3NCOqYxndZfxVIF7et20gaAzuoqhat+5e+b2C9wVl6tyzsirCV/0jV6q1VR?=
 =?us-ascii?Q?3cnIyi14GremXIseU8fz9U+13GBqkZL2IzpkvR7mFufKjyPyJ/H735BL8fq/?=
 =?us-ascii?Q?naWfLKAT8qzhA0lj+RkemKSdDTWH0uQqQBbUzE+DquZX+Xpt5pwulLOkeHdw?=
 =?us-ascii?Q?3QeERRfQyFvdMIx+9SloOeRCm0m42rXgrqZEMxCw6+DUHO7l33+JyBWUSMer?=
 =?us-ascii?Q?4ft11N61sf97KdHcCT+pHXyRTkKvtd7jqBKKhCj2/LSp6qFGvbk5Gm0QD4UA?=
 =?us-ascii?Q?qvWKb/2rIeaLrL0c7kr9AMsYrSke9+l/deSf4v21bzhHWni9h78yt/zzsnLU?=
 =?us-ascii?Q?1dMJ/v6L7tul+gc/DfLbj+EN5gvnpypYaWwgiq5CNTvnNSvgRl2Oj8NPmdYW?=
 =?us-ascii?Q?zHjlCP+EsePrUvjcrOLqeATrx6dmF1cUPFqbteB92OlCvuVftaGBu5CirI9f?=
 =?us-ascii?Q?BgtRWvTB/TVjBODnBHZIVoYTTxYn4JramEnlNSVo2fxy64ns8J2zJRVjCgrP?=
 =?us-ascii?Q?uip/qlb7oCzslU2udQPmramsqTPHw3Mk1627AZQr0Kapv4KsgPgEBvWp+0y8?=
 =?us-ascii?Q?k0YC84Syz3OH0+Z35MkIdyfRKkxVxyB+d6kCs6/XK/dUVlq1HjYY70bX0/ou?=
 =?us-ascii?Q?X+S28ro3vPchEn3G7ZRIR8JBp7KVgbuQCXhrS5mxYpAkhNCPRtDQyK7+fJ31?=
 =?us-ascii?Q?yx94yXNkr1JXfOVWio0cyWMtLnOGsDjeM73oBgiDj4B0EuQ+SYDM1qZZtgQK?=
 =?us-ascii?Q?TN0FqQSNBaJmOJihO2yK3gzg9qxTnIH5NyLuGrz5o5a/tASTd4NAjqKkl96D?=
 =?us-ascii?Q?GJcdMtspCyKpk5v9nvOBRBmdR0yG+yg9UqwKIUhv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65014863-676f-4fc7-eaf5-08dde2778ae6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 19:02:01.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrZ2QZElF7ohEM30JszmmZFWZ0FjFsEjytx35D2pkJZVxNBGN6/kLU1e5JND/RIQ1Ib4EXmECYECjOimS4p9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10456

Add a new rx_frame_size member in the fec_enet_private structure to
decouple frame size configuration from max_buf_size. This allows more
precise control over RX frame length settings. It is particularly useful
for Jumbo frame support because the RX frame size may possible larger than
the allocated RX buffer.

Configure TRUNC_FL (Frame Truncation Length) based on the RX buffer size.
Frames exceeding this limit will be treated as error packets and dropped.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 47317346b2f3..f1032a11aa76 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -621,6 +621,7 @@ struct fec_enet_private {
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
 	unsigned int pagepool_order;
+	unsigned int rx_frame_size;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f046d32a62fb..3f25db23d0de 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1191,7 +1191,7 @@ fec_restart(struct net_device *ndev)
 		else
 			val &= ~FEC_RACC_OPTIONS;
 		writel(val, fep->hwp + FEC_RACC);
-		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
+		writel(fep->rx_frame_size, fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -4560,6 +4560,7 @@ fec_probe(struct platform_device *pdev)
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
 	fep->pagepool_order = 0;
+	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


