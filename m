Return-Path: <netdev+bounces-242798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B8C94FF0
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6C5C4E16E8
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1CD279DAF;
	Sun, 30 Nov 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hh1cG9Ma"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA9277011
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508662; cv=fail; b=IfLy6fpDJgCe0UJPYx1/XdVN1rq0jlNUqaPsK1weI9g3r463MWEwCj/yhlIo2je5DAe9C1mL0ZLENmSkMhQGoB2f1h/TcoUKJxnS4r3APhDK+/bWR7dFIQJUzNrs/X4C++jJNrKkPs6fqMVso0y00qg1D1TlwThptl9A2FUiZ2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508662; c=relaxed/simple;
	bh=pgn8MO1SYxt3O5JD7bmLyb0HAmFuUN3EHUJ8tQgXAq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RUACY+vVZTmc9HWxVoJKW0R5b5zxtkx63FVgEFmA96I/RZTXH9msPjlFVpS6BYu3GiM2PEH88FQu6IoiqqS1agSudapf/bz6nDSp0Mgl5ggSxDaJ0MafjCMmPpfxq6RfkZEtdX46LurUv6N+exIP3z+niksb40hH4bkD8coUaos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hh1cG9Ma; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AypxRR+hKF/DdyWADxErYIooIB/vD5gVycWt175fk5yDI7amY5RAUJaCoP7yOKQiPPl1K/cyE3sQwA+FyneVbW/R3ji72qVUO3QmJTjjsnxk7liP52uB6pnSgvdidhBR8qugW98/0HvnMXJOxUFhUt2Bgj209a/dq/Nuptyl1hned4HVv1xOaDu0/PaikvwJp4woTAttpdVND2qgIWoh729u6dLyclXKtn9PS7pfzKdfX9BlsI7qJHY+bhDRjJ0rna+Mwcq66aF1fuFla7nrdlepn+9/h1tzrpT2UstIuFGKsmiMorwLZy+DP/JQViPHLXj7PXuFVi/7WURuaE9SKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryIg1v3CdjDfdHBqk5t0jyCGxVTxAvuiPh8tABKW7p4=;
 b=tP4leV3+Z4lNeUFMrq/PvkHAbDiIDc2TSkpylJ2dmSRfiWsUiOA8ldsBoXKc+xexsHbroYIMNh/j5mwZVizj/L5snulDFFdL17ktTCGzHyU35DGDDnOglZs2+zssF1Hka3eaW+D1XooGWDGMia6tOJXXIJViUqs1TfcjIloNhuXtAL6ZtxSb9TDUiG2IRlXVsskVQvSTL+7DqAdiNfwbT1TrIL+cL+TXXL4GCwUu09Vc5DcFaAJ4AgZbmPRNmnG7RcM4wHm+H+y8PhatGhDf91vH1pQvbtDLMp77A2ncSmhdSDw/ykOoJGO5kBzitlMk7sj3U4J7y3QGVJHmoqqtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryIg1v3CdjDfdHBqk5t0jyCGxVTxAvuiPh8tABKW7p4=;
 b=Hh1cG9MaF901PfWfsnYsYOfYsep/L2HSYGWthkCgNNoQNZoT/OBKZrSn93oq7OuijtcPwd0+7s1pyYX0c3aR0YXgvCybUJ7XsebAHey5pn6TaBVvwAvPN00qWwdHjaTxmeow0l5FPsrZZk+WK+MLCi5BnojBK3ZB8dLtMfC5DmwJqnxlSf71f6aNy5wmO8s/eqqRFZ/fewq6Ivsez6HPjEMNVOdQR9rR00lTRyP3ZaZuZ0Kg/9/pDIrLPBZl3FcGPYuWInBXppPAOOOZlGpw2W5pugu0lQdJ9Hir9sSmDJU0d6g1FFz/RJlUumvtFfSMyDm7E1mb1cgz8n+WXQbzJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:32 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:32 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 03/15] net: dsa: avoid calling ds->ops->port_hsr_leave() when unoffloaded
Date: Sun, 30 Nov 2025 15:16:45 +0200
Message-Id: <20251130131657.65080-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: 66caf611-08e7-4c4e-96d8-08de3012d1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?preGDK6+pa1NB/Rr/nlrwjBynqzuFExqLLaL1spAHXfXycDxeWbyERkvDDix?=
 =?us-ascii?Q?EPIZf6E62JfPXYHKAUJuqYmS5I9MVlmC4mk6WA98nDc9Xe5vYVmJYlVPCKfm?=
 =?us-ascii?Q?ldEibfH10NczSq51Q56tk+CBnyP+1ZssysoL112lVE8RnJZVHc1rjyU19vQl?=
 =?us-ascii?Q?WDve3I9bzZHBSGs7dpIkNoNbqZ6Nj924i+He3Yj8qQC17bDoA9CowqrJaoFV?=
 =?us-ascii?Q?nGjcy8tzSuXWKhCKoxMAgFdKdL+LFfFRnSzsoM3Ncy/eJWxdDDlazAi4eCSh?=
 =?us-ascii?Q?kStj4G4xF7qldmRANaebE+dVnT0rLjCR+R4sLeiW6niyIj5w6L0Jf+554/7K?=
 =?us-ascii?Q?YaOyZbgIxpqE5cCLTPUd9r7pgA+No7nVRTbBGdZBRgkb6K5Z20rw/WgzlWZ2?=
 =?us-ascii?Q?UX4t4n1FUMfe4gomKB6DN5nLoXrtp7XiXcV91Dk1o+U9aYLwWFgqvVx7/913?=
 =?us-ascii?Q?OOeoAYf1gPIU1etoM3tnIr8wxEvXqhFp6o/J4m3+hglytMA6OzYJ6lGSMvMn?=
 =?us-ascii?Q?d02CmUNwIC0e9juhci3GKVP93W2Pu5uZKEY7yl8QyTok3rcQABmAsZ/762io?=
 =?us-ascii?Q?dydFDh2AodvCUNxFe3sv1cYPloKyeADDZ+jy5WxUzaMrsG3bBWEz6Gz4jrMk?=
 =?us-ascii?Q?+5J+ADVNOACbnvwex8rkisKe0I7UbKweJO1m7mfi/tdKIIH4PLdPQkOu4YPt?=
 =?us-ascii?Q?FsvQgWrW2veZ+Ke/TK2pINcJz6vQXUYf7z8P4L9cJNmwhz/HUL972mRck4nS?=
 =?us-ascii?Q?Y+bY7gwe9yOpNfKcQHZ99YuTXdpazOkifERBoLfZHiWuu+Y36lrSyHYF1juy?=
 =?us-ascii?Q?DxaESa/E7wtCnKBJGOFqcILEcN6zJBjUxojNnVmNzjG7H489e8GJX5Q1/rBR?=
 =?us-ascii?Q?hz6dq4d/Xng7JaQ1gFMkQoOFJi21RH3v/XjvJ+9hN2Ip+pOAOPrUKh0eR+nu?=
 =?us-ascii?Q?eBIHWM+Qnl/otFqe97Y3n/erz2N5Z2vSSNsO1+ZTh9LtJLLXKAFc907EUL+0?=
 =?us-ascii?Q?FU1m/Jjo+/dU7TlwRiPyLmFZ7I2d6/OHZ9fjGawvMD74eoA4K1aCYCurnqZd?=
 =?us-ascii?Q?Asryjg1NJgSOgN/EFHsol6f4dDF4zp/RSzhTAokudJDU0YMDk5BblIR56mbX?=
 =?us-ascii?Q?kwUmkD1MAELvF9TF+Rvc8sO+MKb+qt2CyPppF9zPhb7eVuKNLC72YlUMW6J2?=
 =?us-ascii?Q?yCZ0v/D5Zu+J7xSXGAyfo1Is67pTVhHU8vdCTHEXD3fMGIKjJVcxzaNqN35u?=
 =?us-ascii?Q?eTYf4q92PNMNCNMBw4b9NjDsXOvNf7Om2fo+mwZDgY8V6D7vCS1U0GkFg3VV?=
 =?us-ascii?Q?7YQSXNVOEjyGhEr7SyKq0AFR2FKbkoWfWTRMwEu9/ILdaHv2zJJMRYF5R4LG?=
 =?us-ascii?Q?Mggj//+AFl7s2BGmUoXfLrX23g9FbAzwSIAGztqO6BUd/g8491e6sJ7FNqPE?=
 =?us-ascii?Q?ZQog9C0OUNDmbOYU0EbOE4mPlkds41k0Jei1aXiFOp3PQ4ovvexucgAc4L5s?=
 =?us-ascii?Q?iarwzmb+mXQvINNQfcntFqk9plpatffmr/Ts?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQW7AzEg6c/Mwuf0APN+aXJfueuVkyUu3rFN+/brgT73vLoK4xhia62OeQfa?=
 =?us-ascii?Q?mzxu0IfYYxWaV9xflYGpMqbwL4PsTZCypvPkf/jyZI4q8/ufiPqpreq/C1vA?=
 =?us-ascii?Q?qukBeZ3eKXgdEaL8pbjkvbySpxcjFE9908nmL2bNLFCAT/0Ae/Yy8TaT+iUN?=
 =?us-ascii?Q?6PhqsJ/2E+E+dRMXFwW+4/6G12xH1vlJKBjPx43nGkiaGzz4/jvvK6vsIZMJ?=
 =?us-ascii?Q?i7FWc/Ao5WmRKpcsgSCwUub4Z+I0ShaZYtDy7OM+YjlVMmoPGkSd1pYRYcFi?=
 =?us-ascii?Q?wUPWxwlGpB/CTYT0WBJgCLjFnPh9NR1ixolrfnyGE9iYdsoY9IvUia625znu?=
 =?us-ascii?Q?evW26UbtU+Mw8m/LQoGaYXKGPGEGkdGuK1NFL3UBunjMyzpsqIe2Oq/rr36V?=
 =?us-ascii?Q?2SUZ/45bGnBfxr1Rk8aqKIqgDOcWNnN8CiUtacq0z0tLbp559lF/Yx+x2rK+?=
 =?us-ascii?Q?6lyHD1SU7ERjGoFjx1rUFqetBqDKaJ/xKQso6/Q5jptWokjeDxZETGIjbheJ?=
 =?us-ascii?Q?JR9M+s+NUSTEMN/aSvsu8A/qFZ7NeMlIKK4xRY8+gtWmHlZDmPFrLcv+Wd+/?=
 =?us-ascii?Q?wjNgegFL/I0hMjOo4+VOn2srVY7c8lBHPvv3jnp6IMKZm4pb9oamoveXXMdA?=
 =?us-ascii?Q?NJZb8JGPA3b3NSR1T60czJSkUcNOiNGQvdf841YgpInGPDp/Zg7122YVmzFF?=
 =?us-ascii?Q?cDdgEC2FWs4sB+0VsIHxO96vTB93WPTS5OJooZ4O4KkqZXsMwoPNovHx341l?=
 =?us-ascii?Q?Ubip/uh38BGN4Dqj5ldb5LVXNMXsnMyUp2iS8i1oKkExSHvmxCtxtyJ+YaW0?=
 =?us-ascii?Q?cX/AMD737ZA3M1uuZbTy7viwdBjNg/Y1yNzi5WHsYPqUQ5O+Nez8fNYabusZ?=
 =?us-ascii?Q?Qe0a/wEX0BRZ3vhchOHVLTh4sQ+psUBvLezZ6+fslxAbDYHnuiTADVnknT/2?=
 =?us-ascii?Q?5yDZ6LOD8MUTTD1YmhAawIgwUdzcWpdlAvHerkWiy/aFmJhNsui6Cl3Krdyy?=
 =?us-ascii?Q?iuEDmhN2znzP+ZfCr7VoQomvXBFyO3dYlMeg6YKkyR/0KG28QerqLziNttek?=
 =?us-ascii?Q?bvKLeC2QM+wHqYyqPauIkmXfYm0KLui4Ol5ugxJE4ujv95Z+d/sFpBgR6yKu?=
 =?us-ascii?Q?Ix+qBExoByZAPyGL6Niz1jLJ7yu0djXHLnLav/OrhbyILNDVk9949vD8j1Hx?=
 =?us-ascii?Q?Jq7A2ZWv7jqgWbzhDSWBNKIgFAVivvEVONvI/Hraqgl+GLvbM1W119clKZIL?=
 =?us-ascii?Q?bjGP5NAp8RB4R+9URlJ/spZf/TARcHj6liws0XnyyN34T9mhE3Oj1AzeyRCs?=
 =?us-ascii?Q?2RYNLxOupvKdeZ4hkiTYQeM60Q/czOggMxRSxqjcc+JUh1iswhnpywP05Xq8?=
 =?us-ascii?Q?RMBWMi3WNrqg3aYxGqD03brVYwvRbChrLimF8I9ZvzosNsxouKltoJQp4XXX?=
 =?us-ascii?Q?XxqsiOC7LKLQWVyb5EsAK2UHbuwItdPiRFM5sQyCBspfRy1Q2i2ASabmLCb6?=
 =?us-ascii?Q?uYMze0bBFjjeaXDAhmZDSkY1jxaRoCgyoItZb5IWubFe7CVDZNdz7PywinTt?=
 =?us-ascii?Q?JUsFse7UCLQbHLQl71XOkvLoT6ZZ1o6Xan4MIj0WEH8SRLT/fQDw1HmAq/Od?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66caf611-08e7-4c4e-96d8-08de3012d1de
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:32.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoXGTxYeRtRIVJZxed9EHpS8kdgi4CLFV7YZQ38YdczJ25Nh4KcWWThCLsc0Hg7kuLHZgnKHKASXq8DJmiEK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

This mirrors what we do in dsa_port_lag_leave() and
dsa_port_bridge_leave(): when ds->ops->port_hsr_join() returns
-EOPNOTSUPP, we fall back to a software implementation where dp->hsr_dev
is NULL, and the unoffloaded port is no longer bothered with calls from
the HSR layer.

This helps, for example, with interlink ports which current DSA drivers
don't know how to offload. We have to check only in port_hsr_join() for
the port type, then in port_hsr_leave() we are sure we're dealing only
with known port types.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 082573ae6864..ca3a7f52229b 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1909,6 +1909,9 @@ void dsa_port_hsr_leave(struct dsa_port *dp, struct net_device *hsr)
 	struct dsa_switch *ds = dp->ds;
 	int err;
 
+	if (!dp->hsr_dev)
+		return;
+
 	dp->hsr_dev = NULL;
 
 	if (ds->ops->port_hsr_leave) {
-- 
2.34.1


